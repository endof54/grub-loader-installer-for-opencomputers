-- UNIVERSAL GRUB FOR HDD AND FLOPPY (init.lua on floppy)
local eeprom = component.list("eeprom")()

local grub_code = [[
local inv = component.invoke
local gpu = component.list("gpu")()
local scr = component.list("screen")()
inv(gpu, "bind", scr)

local maxW, maxH = inv(gpu, "maxResolution")
local w = math.min(maxW, 60)
local h = math.min(maxH, 16)
inv(gpu, "setResolution", w, h)

local cur = 1
local menu = {
  {n="1. Boot from HDD (init.lua)", f="/init.lua", t="hdd"},
  {n="2. Boot from Floppy (Floppy Disk)", f="/init.lua", t="floppy"},
  {n="3. Reboot Computer", a="r"},
  {n="4. Power Off", a="s"}
}

local function draw()
  inv(gpu, "setBackground", 0)
  inv(gpu, "fill", 1, 1, w, h, " ")
  inv(gpu, "setForeground", 0xFFFFFF)
  inv(gpu, "set", 3, 2, "GNU GRUB  version 1.1.0-OpenComputers (Tier 3)")
  
  inv(gpu, "set", 1, 4, "┌" .. string.rep("─", w-2) .. "┐")
  for i=5,10 do inv(gpu, "set", 1, i, "│" .. string.rep(" ", w-2) .. "│") end
  inv(gpu, "set", 1, 11, "└" .. string.rep("─", w-2) .. "┘")
  
  for idx, it in ipairs(menu) do
    local y = 4 + idx
    if idx == cur then
      inv(gpu, "setBackground", 0xFFFFFF)
      inv(gpu, "setForeground", 0)
    else
      inv(gpu, "setBackground", 0)
      inv(gpu, "setForeground", 0xFFFFFF)
    end
    local fmt = " %-" .. tostring(w-6) .. "s "
    inv(gpu, "set", 3, y, string.format(fmt, it.n))
  end
  inv(gpu, "setBackground", 0)
  inv(gpu, "setForeground", 0xAAAAAA)
  inv(gpu, "set", 3, 13, "Стрілочки [↑/↓] - вибір, [ENTER] - запуск")
end

draw()
while true do
  local name, _, char, code = computer.pullSignal()
  if name == "key_down" then
    if code == 200 then cur = cur - 1; if cur < 1 then cur = #menu end; draw()
    elseif code == 208 then cur = cur + 1; if cur > #menu then cur = 1 end; draw()
    elseif code == 28 then
      local sel = menu[cur]
      if sel.a == "r" then computer.shutdown(true)
      elseif sel.a == "s" then computer.shutdown()
      else
        local addr = nil
        for fs in component.list("filesystem") do
          local is_floppy = inv(fs, "isReadOnly") or (inv(fs, "getLabel") == "floppy")
          if sel.t == "hdd" and not is_floppy and inv(fs, "exists", sel.f) then addr = fs; break
          elseif sel.t == "floppy" and is_floppy and inv(fs, "exists", sel.f) then addr = fs; break
          end
        end
        
        if addr then
          -- Повністю універсальна емуляція адреси для будь-яких систем та ОС
          computer.getBootAddress = function() return addr end
          computer.setBootAddress = function(a) addr = a end
          
          local function loadfile(file)
            local handle = assert(inv(addr, "open", file, "r"))
            local buffer = ""
            repeat
              local data = inv(addr, "read", handle, 2147483647)
              buffer = buffer .. (data or "")
            until not data
            inv(addr, "close", handle)
            return assert(load(buffer, "=" .. file, "t", _G))
          end

          loadfile("/init.lua")()
          break
        else
          inv(gpu, "setBackground", 0)
          inv(gpu, "setForeground", 0xFF0000)
          inv(gpu, "set", 3, 14, "Помилка: Носій або файл не знайдено!")
          computer.beep(400, 0.5)
        end
      end
    end
  end
end
]]

if eeprom then
  inv(eeprom, "set", grub_code)
  inv(eeprom, "setLabel", "GRUB Boot Loader")
  computer.beep(1000, 0.1)
  computer.beep(1300, 0.2)
  computer.shutdown()
else
  computer.beep(400, 1)
end

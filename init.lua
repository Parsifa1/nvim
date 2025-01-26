-- add .compiled as path
local compiled = "/.compiled/lua/?.lua"
local path = vim.fn.stdpath "config" .. compiled
package.path = package.path .. ";" .. path

--- start up file
require "packer"
require "keymap"
require "option"

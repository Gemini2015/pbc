require "protobuf"

addr = io.open("../../build/test64.pb","rb")
buffer = addr:read "*a"
addr:close()

protobuf.register(buffer)

data = {
	v_int64 = '-9223372036854775808',
	v_uint64 = '18446744073709551615',
	v_sint64 = '-9223372036854775808',
	v_fixed64 = '-9223372036854775808',
	v_sfixed64 = '-9223372036854775808',
}
print('data')
for k, v in pairs(data) do
	print('k ' .. k .. ' value ' .. v .. ' type ' .. type(v))
end
code = protobuf.encode("Person", data)

local file = io.open("code64", "wb")
file:write(code)
file:close()

decode = protobuf.decode("Person" , code)

print('decode')
for k, v in pairs(decode) do
	print('k ' .. k .. ' value ' .. v .. ' type ' .. type(v))
end

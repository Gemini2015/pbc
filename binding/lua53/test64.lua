local protobuf = require "protobuf"

addr = io.open("../../build/test64.pb","rb")
buffer = addr:read "*a"
addr:close()

protobuf.register(buffer)

data = {
	v_int64 = -2305843009213693951,
	v_uint64 = -2305843009213693951,
	v_sint64 = -2305843009213693951,
	v_fixed64 = -2305843009213693951,
	v_sfixed64 = -2305843009213693951,
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
for k, v in pairs(data) do
	print('k ' .. k .. ' value ' .. v .. ' type ' .. type(v))
end

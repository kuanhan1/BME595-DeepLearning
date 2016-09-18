local NeuralNetworkLib = require 'NeuralNetwork'
local logicGatesLib = require 'logicGates'
local mnist = require 'mnist'
local img2numLib = require 'img2num'
require 'nn'

--  test with minist dataset
img2numLib.train()
--  local trainset = mnist.traindataset()
local testset = mnist.testdataset()
--  print(trainset.size) -- to retrieve the size
print(testset.size) -- to retrieve the size
local i
local mark = 0
for i = 1 , 100 do
    local ex = testset[i]
    local img = ex.x -- the input (a 28x28 ByteTensor)
    local y = ex.y -- the label (0--9)
    local printy = img2numLib.forward(img)
    print(y,printy)
    if printy == y then
        mark = mark + 1
    end
end
print('accuracy rate after training the whole train-set for a time:',mark,'%')


--  test with the tutorial case
--  test only for batch train (non-batch case tested in logic module)

--[[
NeuralNetworkLib.build({2,2,2})
local layer_temp
local setvalue
layer_temp = NeuralNetworkLib.getLayer(1)
-- setvalue = torch.Tensor({{0.35,0.15,0.2};{0.35,0.25,0.3}}):clone()
layer_temp[{{},{}}] = torch.Tensor({{0.35,0.15,0.2};{0.35,0.25,0.3}})
layer_temp = NeuralNetworkLib.getLayer(2)
layer_temp[{{},{}}] = torch.Tensor({{0.6,0.4,0.45};{0.6,0.5,0.55}})
--print(NeuralNetworkLib.getLayer(1))
--print(NeuralNetworkLib.getLayer(2))
--  in_test = torch.Tensor({1,0.05,0.1})
in_test = torch.Tensor({{1,1};{0.5,0.1};{0.7,0.1}})
temp_forward = NeuralNetworkLib.forward(in_test)
print(temp_forward)
target = torch.Tensor({{0.01,0.05};{0.9,0.3}})
for i = 1 , 100000 do
    temp_forward = NeuralNetworkLib.forward(in_test)
    NeuralNetworkLib.backward(target)
    NeuralNetworkLib.updateParams(0.5)
end
temp_forward = NeuralNetworkLib.forward(in_test)
print(temp_forward)
--]]

--  test with logic gates

--[[
logicGatesLib.AND.train()
print('and result:')
print('false and false should be 0: ',logicGatesLib.AND.forward(false, false))
print('false and true should be 0: ',logicGatesLib.AND.forward(false, true))
print('true and false should be 0: ',logicGatesLib.AND.forward(true, false))
print('true and true should be 1: ',logicGatesLib.AND.forward(true, true))
logicGatesLib.AND.set()
print('true and false should be 0. calculated be setted w parameters: ',logicGatesLib.AND.forward(true, false))

logicGatesLib.OR.train()
print('or result:')
print('false and false should be 0: ',logicGatesLib.OR.forward(false, false))
print('false and true should be 1: ',logicGatesLib.OR.forward(false, true))
print('true and false should be 1: ',logicGatesLib.OR.forward(true, false))
print('true and true should be 1: ',logicGatesLib.OR.forward(true, true))
logicGatesLib.OR.set()
print('true and false should be 1. calculated be setted w parameters: ',logicGatesLib.OR.forward(true, false))

logicGatesLib.NOT.train()
print('not result:')
print('true should be 0: ',logicGatesLib.NOT.forward(false))
print('false should be 1: ',logicGatesLib.NOT.forward(true))
logicGatesLib.NOT.set()
print('true should be 0. false should be 1 calculated be setted w parameters: ',logicGatesLib.NOT.forward(true),logicGatesLib.NOT.forward(false))

logicGatesLib.XOR.train()
print('xor result:')
print('false and false should be 0: ',logicGatesLib.XOR.forward(false, false))
print('false and true should be 1: ',logicGatesLib.XOR.forward(false, true))
print('true and false should be 1: ',logicGatesLib.XOR.forward(true, false))
print('true and true should be 0: ',logicGatesLib.XOR.forward(true, true))
logicGatesLib.XOR.set()
print('true and false should be 1. calculated be setted w parameters: ',logicGatesLib.XOR.forward(true, false))
--]]

--  test with MNIST

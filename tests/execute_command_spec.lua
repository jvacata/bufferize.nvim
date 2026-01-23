local bufferize = require('bufferize.init')

describe('Execute command', function()
    it('Should execute vim command', function()
        assert.are.same("test results", bufferize.execute_command('echo "test result"'))
    end)
end)

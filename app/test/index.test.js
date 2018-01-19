const chai = require('chai');
const testResultsProcessingFunction = require('../src/index');

chai.should();

describe('When Develop The Profession function is called with "success" personName', () => {
  it('then error message with action "success" is passed to the callback', (done) => {
    const event = { personName: 'success' };

    testResultsProcessingFunction.handler(event, null, (error) => {
      error.should.have.property('message').eql('{"action":"success","personName":"success"}');
      done();
    });
  });
});

describe('When Develop The Profession function is called with "dataError" personName', () => {
  it('then error message with action "dataError" is passed to the callback', (done) => {
    const event = { personName: 'dataError' };

    testResultsProcessingFunction.handler(event, null, (error) => {
      error.should.have.property('message').eql('{"action":"dataError","personName":"dataError"}');
      done();
    });
  });
});

describe('When Develop The Profession function is called with "serverError" personName', () => {
  it('then error message with action "serverError" is passed to the callback', (done) => {
    const event = { personName: 'serverError' };

    testResultsProcessingFunction.handler(event, null, (error) => {
      error.should.have.property('message').eql('{"action":"serverError","personName":"serverError"}');
      done();
    });
  });
});

describe('When Develop The Profession function is called with not supported personName', () => {
  it('then error message with action "incorrectTestData" is passed to the callback', (done) => {
    const event = { personName: 'anyOtherName' };

    testResultsProcessingFunction.handler(event, null, (error) => {
      error.should.have.property('message').eql('{"action":"incorrectTestData","personName":"anyOtherName"}');
      done();
    });
  });
});

exports.handler = (event, context, callback) => {
  const { personName } = event;

  if (personName.includes('success')) {
    callback(new Error(JSON.stringify({ action: 'success', personName })));
  } else if (personName.includes('dataError')) {
    callback(new Error(JSON.stringify({ action: 'dataError', personName })));
  } else if (personName.includes('serverError')) {
    callback(new Error(JSON.stringify({ action: 'serverError', personName })));
  } else {
    callback(new Error(JSON.stringify({ action: 'incorrectTestData', personName })));
  }
};

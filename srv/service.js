const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

  const externalBP = await cds.connect.to('apihub_sandbox');

  this.on('READ', 'A_BusinessPartner', async (req) => {
    try {
      return await externalBP.run(req.query);
    } catch (err) {
      console.error('Error calling external service:', err);
      req.error(500, 'Failed to fetch Business Partners');
    }
  });

});
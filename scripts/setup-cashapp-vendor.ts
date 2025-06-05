import { setupAndVerifyVendorCashAppSession } from '../server/src/integrations/cashapp.integration'

setupAndVerifyVendorCashAppSession()
  .then((details) => {
    if (details) {
      console.log('Setup complete. Vendor Customer ID:', details.customerId)
    } else {
      console.error('Setup failed.')
    }
  })
  .catch((err) => console.error('Setup script error:', err))

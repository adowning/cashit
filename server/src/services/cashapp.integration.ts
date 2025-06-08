// src/lib/cashapp-integration.ts
// IMPORTANT: This is a conceptual outline.
// Full implementation requires adapting the detailed CashAppClient interaction logic
// from the previous comprehensive response, focusing on:
// - Securely initializing and managing the VENDOR's CashApp session.
// - Using client.syncEntities() to fetch transactions.
// - Filtering for payments RECEIVED BY the vendor.
// - Extracting senderCashtag (potentially by cross-referencing senderId with other synced Customer entities).
// - Persisting the client session and lastSyncToken.

import { CashAppClient } from 'server/cashapp/lib/cashapp' // Adjust path
import * as fs from 'fs-extra' // Use namespace import for better type support
import path from 'path'

// Configuration - ideally from environment variables
// Use bracket notation for environment variables to satisfy TypeScript
const CASHAPP_VENDOR_DATA_DIR = process.env['CASHAPP_VENDOR_DATA_DIR'] || './.cashapp_vendor_data'
const VENDOR_SESSION_FILE = path.join(CASHAPP_VENDOR_DATA_DIR, 'vendor_session.json')
const LAST_SYNC_TOKEN_FILE_PREFIX = 'last_sync_token_' // Per vendor customer ID
const VENDOR_DETAILS_FILE = path.join(CASHAPP_VENDOR_DATA_DIR, 'vendor_details.json') // To store customer ID and cashtag

export interface VendorDetails {
  customerId: string
  cashtag?: string
  profileToken?: string
}
export interface ReceivedCashAppPayment {
  paymentToken: string
  senderId?: string
  senderCashtag?: string // e.g., "$SomeUser"
  amount: {
    amountInCents: number
    currencyCode: string // e.g., "USD" or numeric "840"
  }
  note?: string
  createdAt: Date
}

export async function setupAndVerifyVendorCashAppSession(): Promise<VendorDetails | null> {
  await fs.ensureDir(CASHAPP_VENDOR_DATA_DIR)
  let client: CashAppClient
  let vendorDetails: VendorDetails | null = null

  if (await fs.pathExists(VENDOR_SESSION_FILE)) {
    console.log(
      `[CashAppSetup] Found existing vendor session file at ${VENDOR_SESSION_FILE}. Attempting to load and verify...`
    )
    try {
      const sessionJson = await fs.readFile(VENDOR_SESSION_FILE, 'utf-8')
      client = CashAppClient.fromJSON(sessionJson)
      // Verify session by fetching profile
      const profileResponse = await client.getProfile() // This refreshes client.profileToken and client.allKnownRanges

      const customerId = profileResponse.profile?.customer?.id
      const cashtag = profileResponse.profile?.customer?.cashtag?.name

      if (!customerId) {
        throw new Error(
          'Failed to retrieve customer ID from existing session. Session may be invalid.'
        )
      }

      vendorDetails = {
        customerId: customerId,
        cashtag: cashtag ? `$${cashtag}` : undefined,
        profileToken: client.profileToken as string, // profileToken is set on client by getProfile()
      }

      // Re-save the session as getProfile() might update its state (e.g., allKnownRanges)
      await fs.writeFile(VENDOR_SESSION_FILE, client.toJSON())
      await fs.writeJson(VENDOR_DETAILS_FILE, vendorDetails)

      console.log(
        `[CashAppSetup] Vendor session loaded and verified successfully. Cashtag: ${vendorDetails.cashtag}, Customer ID: ${vendorDetails.customerId}`
      )
      return vendorDetails
    } catch (error: any) {
      console.warn(
        `[CashAppSetup] Failed to load or verify existing vendor session: ${error.message}. Attempting to initialize a new session.`
      )
      // Proceed to initialize a new session if loading/verification fails
    }
  }

  // If no session file or existing session was invalid, initialize a new one.
  console.log(
    '[CashAppSetup] No valid session found. Initializing a new vendor Cash App session...'
  )
  console.log(
    '[CashAppSetup] NOTE: This step might require user interaction if Cash App API presents a challenge (e.g., 2FA, email code) for new sessions via the underlying library.'
  )

  try {
    client = await CashAppClient.initialize({
      // proxyOptions: {} // Add if your server needs a SOCKS proxy
    })
    console.log(
      '[CashAppSetup] CashAppClient initialized. Attempting to initiate session with API...'
    )

    // THIS IS THE POTENTIALLY INTERACTIVE STEP, handled by the cashapp library.
    // If the library is run in a non-TTY environment and needs input, it might hang or error.
    await client.initiateSession()
    console.log('[CashAppSetup] Session initiated with Cash App API. Fetching profile...')

    const profileResponse = await client.getProfile()
    const customerId = profileResponse.profile?.customer?.id
    const cashtag = profileResponse.profile?.customer?.cashtag?.name

    if (!customerId) {
      throw new Error("Could not retrieve vendor's customer ID after new session initiation.")
    }

    vendorDetails = {
      customerId: customerId,
      cashtag: cashtag ? `$${cashtag}` : undefined,
      profileToken: client.profileToken as string,
    }

    await fs.writeFile(VENDOR_SESSION_FILE, client.toJSON())
    await fs.writeJson(VENDOR_DETAILS_FILE, vendorDetails)

    console.log(
      `[CashAppSetup] New vendor session successfully initialized and saved. Cashtag: ${vendorDetails.cashtag}, Customer ID: ${vendorDetails.customerId}`
    )
    console.log(
      `[CashAppSetup] Ensure VENDOR_CASHAPP_INTERNAL_CUSTOMER_ID is set to: ${vendorDetails.customerId}`
    )
    return vendorDetails
  } catch (error: any) {
    console.error(
      `[CashAppSetup] CRITICAL ERROR during new session initialization: ${error.message}`,
      error.stack
    )
    console.error(
      '[CashAppSetup] Manual intervention may be required to set up the vendor session file.'
    )
    console.error(
      '[CashAppSetup] If interaction was needed (e.g., for 2FA), this process cannot complete automatically in a non-interactive server environment without a pre-established session.'
    )
    return null
  }
}

/**
 * Loads vendor details (customerId, cashtag) from the persisted file.
 * This is what your services would typically use after the one-time setup.
 */
export async function getPersistedVendorDetails(): Promise<VendorDetails | null> {
  if (await fs.pathExists(VENDOR_DETAILS_FILE)) {
    try {
      const details = await fs.readJson(VENDOR_DETAILS_FILE)
      if (details.customerId) {
        return details
      }
    } catch (error: any) {
      console.error(`[CashAppLoad] Error reading vendor details file: ${error.message}`)
    }
  }
  console.warn(
    `[CashAppLoad] Vendor details file not found or invalid at ${VENDOR_DETAILS_FILE}. Run setupAndVerifyVendorCashAppSession() first.`
  )
  return null
}

/**
 * Gets an authenticated CashAppClient for the vendor.
 * Relies on a pre-existing and valid session file.
 * This is preferred for regular operations after initial setup.
 */
export async function getAuthenticatedVendorClient(): Promise<CashAppClient> {
  await fs.ensureDir(CASHAPP_VENDOR_DATA_DIR)
  if (!(await fs.pathExists(VENDOR_SESSION_FILE))) {
    throw new Error(
      `[CashAppClient] Vendor session file (${VENDOR_SESSION_FILE}) not found. Please run the setup function first.`
    )
  }

  try {
    const sessionJson = await fs.readFile(VENDOR_SESSION_FILE, 'utf-8')
    const client = CashAppClient.fromJSON(sessionJson)
    // Optionally, you could add a very lightweight check here, but getProfile() is more thorough
    // For instance, check if client.authorization exists.
    if (!client.authorization) {
      throw new Error(
        'Loaded session is missing authorization. Session might be corrupted or incomplete.'
      )
    }
    return client
  } catch (error: any) {
    console.error(
      `[CashAppClient] Failed to load vendor session from ${VENDOR_SESSION_FILE}: ${error.message}`
    )
    throw new Error(
      `Failed to load vendor session, it may be corrupted or require re-initialization: ${error.message}`
    )
  }
}

// --- Example of how you might trigger this setup (e.g., via a CLI command for your app) ---
// This is NOT for server startup, but for the ONE-TIME setup.
// For example, you could create a simple Bun script:
//
// file: scripts/setup-cashapp-vendor.ts
// import { setupAndVerifyVendorCashAppSession } from '../src/lib/cashapp-integration';
//
// setupAndVerifyVendorCashAppSession()
//   .then(details => {
//     if (details) {
//       console.log("Setup complete. Vendor Customer ID:", details.customerId);
//     } else {
//       console.error("Setup failed.");
//     }
//   })
//   .catch(err => console.error("Setup script error:", err));
//
// Then run: bun run scripts/setup-cashapp-vendor.ts

async function getVendorCashAppClient(): Promise<CashAppClient> {
  await fs.ensureDir(CASHAPP_VENDOR_DATA_DIR)
  if (!(await fs.pathExists(VENDOR_SESSION_FILE))) {
    // In a real scenario, this should trigger an alert or a manual re-auth process.
    // For this example, we'll throw. The initializeVendorSession should be run once securely.
    throw new Error('Vendor Cash App session file not found. Please initialize it first.')
  }
  const sessionJson = await fs.readFile(VENDOR_SESSION_FILE, 'utf-8')
  const client = CashAppClient.fromJSON(sessionJson)
  // TODO: Add client.proxyOptions if needed
  return client
}

export async function fetchReceivedVendorPayments(
  vendorInternalCustomerId: string
): Promise<ReceivedCashAppPayment[]> {
  const client = await getVendorCashAppClient()
  const lastSyncTokenFile = path.join(
    CASHAPP_VENDOR_DATA_DIR,
    `${LAST_SYNC_TOKEN_FILE_PREFIX}${vendorInternalCustomerId}.txt`
  )
  let oldestToken: string | null = null

  if (await fs.pathExists(lastSyncTokenFile)) {
    oldestToken = await fs.readFile(lastSyncTokenFile, 'utf-8')
  }

  const syncResult = await client.syncEntities({
    newestToken: null,
    oldestToken: oldestToken,
    allKnownRanges: client.allKnownRanges || [],
    isProtocolChangeSafe: true,
    trigger: null,
  })

  const newPayments: ReceivedCashAppPayment[] = []
  if (syncResult.entities) {
    for (const entity of syncResult.entities) {
      if (entity.payment?.payment) {
        const p = entity.payment.payment
        // PaymentState.COMPLETE = 6, Role.RECIPIENT = 2
        if (p.recipientId === vendorInternalCustomerId && p.state === 6 && p.role === 2) {
          let senderCashtag: string | undefined = undefined
          if (p.senderId) {
            const senderCustomerEntity = syncResult.entities.find(
              (e: { customer?: { customer?: { id: string } } }) => e.customer?.customer?.id === p.senderId
            )
            senderCashtag = senderCustomerEntity?.customer?.customer?.cashtag?.name
          }
          newPayments.push({
            paymentToken: p.token,
            senderId: p.senderId,
            senderCashtag: senderCashtag ? `$${senderCashtag}` : undefined,
            amount: {
              amountInCents: p.amount.amount, // Assuming this is in cents
              currencyCode: p.amount.currencyCode.toString(),
            },
            note: p.note,
            createdAt: new Date(p.createdAt),
          })
        }
      }
    }
  }

  if (syncResult.newestToken) {
    await fs.writeFile(lastSyncTokenFile, syncResult.newestToken)
  }
  await fs.writeFile(VENDOR_SESSION_FILE, client.toJSON()) // Save updated client state

  return newPayments
}

// This function should be run securely ONCE to set up the vendor's session.
export async function initializeVendorSessionInteractive() {
  console.log('Attempting to initialize vendor Cash App session...')
  await fs.ensureDir(CASHAPP_VENDOR_DATA_DIR)
  if (await fs.pathExists(VENDOR_SESSION_FILE)) {
    console.log('Vendor session file already exists. To re-initialize, delete it first.')
    const currentSession = await fs.readFile(VENDOR_SESSION_FILE, 'utf-8')
    const clientCheck = CashAppClient.fromJSON(currentSession)
    try {
      const profile = await clientCheck.getProfile()
      console.log(
        `Existing session for Cashtag: $${profile.profile?.customer?.cashtag?.name}, Customer ID: ${profile.profile?.customer?.id}`
      )
      console.log(`Set VENDOR_CASHAPP_INTERNAL_CUSTOMER_ID=${profile.profile?.customer?.id}`)
      return
    } catch (e) {
      console.warn('Could not validate existing session, re-initializing might be needed.', e)
    }
  }

  const client = await CashAppClient.initialize({
    /* proxy options if needed */
  })
  await client.initiateSession() // This is where interaction might be needed if 2FA etc.
  // The library might require manual steps for the first auth.
  // This part is tricky for a fully automated server setup without CLI interaction.
  // The `cashapp` CLI uses `cashapp init` which handles this.
  // For a server, you might need to run `cashapp init` manually once
  // and then copy the generated `~/.cashapp/session.json` to `VENDOR_SESSION_FILE`.

  console.log('Session initiated with Cash App. Fetching profile...')
  const profile = await client.getProfile()
  const vendorCustomerId = profile.profile?.customer?.id
  const vendorCashtag = profile.profile?.customer?.cashtag?.name

  if (!vendorCustomerId) {
    throw new Error("Could not retrieve vendor's customer ID after session initiation.")
  }

  console.log(
    `Vendor CashApp Initialized. Cashtag: $${vendorCashtag}, Customer ID: ${vendorCustomerId}`
  )
  console.log(
    `IMPORTANT: Set VENDOR_CASHAPP_INTERNAL_CUSTOMER_ID=${vendorCustomerId} in your .env file.`
  )

  await fs.writeFile(VENDOR_SESSION_FILE, client.toJSON())
  console.log(`Vendor session saved to ${VENDOR_SESSION_FILE}`)
}

import { PrismaClient } from '../server/prisma/generated/client'
import * as fs from 'fs'
import * as path from 'path'

const prisma = new PrismaClient()

async function importGames() {
  try {
    // Read the games.json file
    const filePath = path.join(__dirname, './games.json')
    const jsonData = fs.readFileSync(filePath, 'utf8')
    const games = JSON.parse(jsonData)

    console.log(`Found ${games.length} games to import`)

    // Clear existing games if needed
    // Uncomment the next line if you want to delete all existing games before import
    // await prisma.game.deleteMany({})

    // Import each game
    let importedCount = 0
    for (const game of games) {
      // Convert boolean values if stored as integers
      const gameData = {
        ...game,
        category: 'SLOTS',
        createdAt: new Date(game.createdAt),
        updatedAt: new Date(game.updatedAt),
        // developer: 'pragmatic',
        isActive: true,
        supportedProviders: ['PRAGMATICPLAY'],
        operator: {
          connect: {
            id: 'cmbben58m0000mdzr9ti87sax',
          },
        },
        gameProvider: {
          connect: {
            id: 'cmbbeokyv004tmdzr1hqhjryn',
          },
        },
        // checked: game.checked === 1 ? true : false,
        // status: Number(game.status),
      }

      // Use upsert to either update existing records or create new ones
      await prisma.game.upsert({
        where: { id: game.id },
        update: gameData,
        create: gameData,
      })

      importedCount++
      if (importedCount % 10 === 0) {
        console.log(`Imported ${importedCount} games...`)
      }
    }

    console.log(`Successfully imported ${importedCount} games`)
  } catch (error) {
    console.error('Error importing games:', error)
  } finally {
    await prisma.$disconnect()
  }
}

// Run the import function
importGames()
  .then(() => console.log('Import completed'))
  .catch((error) => console.error('Import failed:', error))

// npx tsx scripts/verify-data.ts

import { query } from '../src/config/database.js';

async function verifyData() {
  try {
    console.log('Verifying database data...\n');

    const neighborhoods = await query('SELECT COUNT(*) as count FROM neighborhoods');
    console.log(`Neighborhoods: ${neighborhoods[0].count}`);

    const greenSpaces = await query('SELECT COUNT(*) as count FROM green_spaces');
    console.log(`Green Spaces: ${greenSpaces[0].count}`);

    const airReadings = await query('SELECT COUNT(*) as count FROM air_quality_readings');
    console.log(`Air Quality Readings: ${airReadings[0].count}`);

    const propertyValues = await query('SELECT COUNT(*) as count FROM property_values');
    console.log(`Property Values: ${propertyValues[0].count}`);

    console.log('\nSample Aggregated Data:');
    const aggregated = await query(`
      SELECT 
        n.name,
        COUNT(DISTINCT gs.id) as green_space_count,
        AVG(aqr.pm2_5) as avg_pm2_5,
        AVG(pv.avg_property_value) as avg_property_value
      FROM neighborhoods n
      LEFT JOIN green_spaces gs ON n.id = gs.neighborhood_id
      LEFT JOIN air_quality_readings aqr ON n.id = aqr.neighborhood_id
      LEFT JOIN property_values pv ON n.id = pv.neighborhood_id
      GROUP BY n.id, n.name
    `);

    console.table(aggregated);

  } catch (error) {
    console.error('Verification failed:', error);
  }
}

verifyData();
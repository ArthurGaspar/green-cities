// npx tsx scripts/test-connection.ts

import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

async function testConnection() {
  try {
    const connection = await mysql.createConnection({
      host: process.env.DB_HOST,
      port: parseInt(process.env.DB_PORT || '3306'),
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
    });

    console.log('Successfully connected to MySQL database!');

    // Test reading from db
    const [neighborhoods] = await connection.execute('SELECT COUNT(*) as count FROM neighborhoods');
    console.log(`Number of neighborhoods: ${(neighborhoods as any[])[0].count}`);

    await connection.end();
    console.log('Connection closed');

  } catch (error) {
    console.error('Connection failed:', error);
  }
}

testConnection();

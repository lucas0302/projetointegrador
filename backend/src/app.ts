import 'reflect-metadata';
import 'express-async-errors';
import express, { Express } from 'express';
import cors from 'cors';
import { handleApplicationErrors } from './middlewares/error.middleware';
import { router } from './routers/index';
import { loadEnv, connectDb, disconnectDB } from './config';
import path from 'path';

loadEnv();
const uploadsDir = path.resolve(__dirname, '.', 'uploads');

const app = express();
app
  .use(cors())
  .use(express.json())
  .get('/health', (_req, res) => res.send('OK!'))
  .use(router)
  .use(handleApplicationErrors);

export function init(): Promise<Express> {
  connectDb();
  return Promise.resolve(app);
}

export async function close(): Promise<void> {
  await disconnectDB();
}

export default app;

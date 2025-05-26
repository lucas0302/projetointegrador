import { Request, Response, NextFunction } from 'express';
import { AppError } from '../errors/AppError';

export function handleApplicationErrors(
  error: Error,
  _req: Request,
  res: Response,
  _next: NextFunction
) {
  if (error instanceof AppError) {
    return res.status(error.statusCode).json({ error: error.message });
  }

  return res.status(500).json({ error: 'Internal server error' });
} 
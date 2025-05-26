import { Request, Response } from 'express';
import { AuthService } from '../services/auth.service';
import Joi from 'joi';
import { AppError } from '../errors/AppError';

const authService = new AuthService();

const registerSchema = Joi.object({
  name: Joi.string().required(),
  email: Joi.string().email().required(),
  username: Joi.string().required(),
  password: Joi.string().min(6).required()
});

const loginSchema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().required()
});

export class AuthController {
  async register(req: Request, res: Response) {
    try {
      const { error } = registerSchema.validate(req.body);
      if (error) {
        return res.status(400).json({ error: error.details[0].message });
      }

      const { name, email, username, password } = req.body;
      const result = await authService.register(name, email, username, password);
      
      return res.status(201).json(result);
    } catch (error: any) {
      if (error instanceof AppError) {
        return res.status(error.statusCode).json({ error: error.message });
      }
      return res.status(500).json({ error: 'Internal server error' });
    }
  }

  async login(req: Request, res: Response) {
    try {
      const { error } = loginSchema.validate(req.body);
      if (error) {
        return res.status(400).json({ error: error.details[0].message });
      }

      const { email, password } = req.body;
      const result = await authService.login(email, password);
      
      return res.status(200).json(result);
    } catch (error: any) {
      if (error instanceof AppError) {
        return res.status(error.statusCode).json({ error: error.message });
      }
      return res.status(500).json({ error: 'Internal server error' });
    }
  }

  async logout(req: Request, res: Response) {
    try {
      // Como estamos usando JWT tokens, não precisamos fazer nada no servidor
      // O token será removido pelo cliente
      
      return res.status(200).json({ message: 'Logout realizado com sucesso' });
    } catch (error: any) {
      return res.status(500).json({ error: 'Erro interno do servidor' });
    }
  }
} 
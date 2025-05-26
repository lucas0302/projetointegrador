import { Router } from 'express';
import { AuthController } from '../controllers/auth.controller';

const router = Router();
const authController = new AuthController();
//rota para cadastro e login
router.post('/register', authController.register);
router.post('/login', authController.login);
console.log('auth.routes.ts');

export default router; 
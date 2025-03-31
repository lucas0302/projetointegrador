import { Participant, PrismaClient, Skin, User } from '@prisma/client';
import bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  // Limpar os dados das tabelas no banco de dados, respeitando a ordem dos relacionamentos
  //await prisma.user.deleteMany();
  //await prisma.skin.deleteMany();
  //await prisma.participant.deleteMany();

  // Criar usuários
  //const user1 = await prisma.user.create({
  //  data: {
  //    email: 'admin@gmail.com',
  //    password: await bcrypt.hash('admin', 10),
  //    role: 'ADMIN',
  //  },
  //});
  

}

main()
  .catch((e) => {
    console.error(e);
    //process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

import * as dotenv from 'dotenv';
import { PrismaClient } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import * as path from 'path';

dotenv.config({ path: path.join(__dirname, '.env') });
if (!process.env.DATABASE_URL) {
  process.env.DATABASE_URL = 'postgresql://postgres:postgres123@localhost:5434/vibenex?schema=public';
}

const connectionString = process.env.DATABASE_URL;
const adapter = new PrismaPg({ connectionString });
const prisma = new PrismaClient({ adapter });

async function run() {
  const user = await prisma.user.findFirst();
  if (!user) return console.error("No user found");
  
  // Check if mock community exists
  let community = await prisma.community.findFirst({ where: { slug: 'design-comm' } });
  
  if (!community) {
    community = await prisma.community.create({
      data: {
        name: 'Cộng đồng Thiết kế',
        slug: 'design-comm',
        memberCount: 1,
        members: {
          create: {
            userId: user.id,
            role: 'OWNER',
          },
        },
      },
    });
  }

  // Create or update mock channels
  await prisma.channel.upsert({
    where: { id: 'mock-chat-channel' },
    update: { type: 'LIVE_CHAT' },
    create: {
      id: 'mock-chat-channel',
      communityId: community.id,
      name: 'Review UI/UX tháng 5',
      type: 'LIVE_CHAT',
    },
  });

  await prisma.channel.upsert({
    where: { id: 'mock-voice-channel' },
    update: { type: 'VOICE' },
    create: {
      id: 'mock-voice-channel',
      communityId: community.id,
      name: 'Flutter Vietnam Chill',
      type: 'VOICE',
    },
  });

  console.log('Mock channels created successfully!');
}

run().catch(console.error).finally(() => prisma.$disconnect());

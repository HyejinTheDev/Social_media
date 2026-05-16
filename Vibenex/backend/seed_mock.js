const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function run() {
  const user = await prisma.user.findFirst();
  
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
    update: {},
    create: {
      id: 'mock-chat-channel',
      communityId: community.id,
      name: 'Review UI/UX tháng 5',
      type: 'LIVE_CHAT',
    },
  });

  await prisma.channel.upsert({
    where: { id: 'mock-voice-channel' },
    update: {},
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

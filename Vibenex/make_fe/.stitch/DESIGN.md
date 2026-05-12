# Design System: Vibenex — Community Social Platform

## 1. Visual Theme & Atmosphere
Vibenex is NOT another Instagram clone. It is a **community-driven social platform** where users join and participate in topic-based Spaces (like Discord servers meets Reddit communities). The visual language emphasizes **belonging, conversation, and discovery** — not vanity metrics.

The aesthetic is "Cosmic Lounge" — dark, warm, and inviting like a late-night creative workspace. Subtle gradients evoke depth and dimension without flashiness. The UI feels like exploring a galaxy of micro-communities, each with its own personality.

## 2. Color Palette & Roles
- **Nebula Violet** (#7C3AED) — Primary brand, Space highlights, active navigation
- **Aurora Teal** (#06B6D4) — Secondary accent for online status, live indicators, and interactive elements
- **Ember Orange** (#F97316) — Trending/Hot indicators, upvote actions, energy moments
- **Void Black** (#09090B) — Primary background, immersive and deep
- **Obsidian** (#18181B) — Card surfaces, channel backgrounds
- **Graphite** (#27272A) — Elevated surfaces, input fields, modals
- **Zinc Border** (#3F3F46) — Subtle borders, dividers
- **Cloud White** (#FAFAFA) — Primary text
- **Stone Gray** (#A1A1AA) — Secondary text, meta info, timestamps
- **Coral Pink** (#FB7185) — Hearts, reactions, notification badges
- **Mint Green** (#34D399) — Online status, success, joined confirmations

## 3. Typography Rules
- **Font Family**: Space Grotesk for headings (geometric, techy feel), Inter for body
- **Space Names**: Bold (700), 18px, slightly tight tracking (-0.01em)
- **Channel Names**: Medium (500), 15px, prefixed with # symbol
- **Messages/Posts**: Regular (400), 15px, relaxed line-height (1.6)
- **Meta/Badges**: Medium (500), 11px, uppercase tracking (0.05em)
- **Member Count**: Tabular numerals, Stone Gray

## 4. Component Stylings
- **Space Cards**: Rounded (20px), Obsidian background, 1px Zinc border. Feature a banner image (120px tall) at top, Space icon overlay (48px, rounded 12px), name + member count + short description. NO Instagram-style photo grids.
- **Channel List Items**: Left-aligned # prefix in Stone Gray, channel name in Cloud White, unread indicator as a small Nebula Violet dot. Active channel has subtle Violet tint background.
- **Message Bubbles**: NO bubbles. Use flat, left-aligned message layout like Discord — avatar (32px) on left, username + timestamp on first line, message content below. Hover/long-press reveals reaction bar.
- **Reaction Chips**: Pill-shaped (full-round), Graphite background, emoji + count, tappable. Active reaction has Violet tint.
- **Thread Previews**: Indented with a thin Violet left-border (2px). Shows reply count and participant avatars (stacked circles).
- **Floating Action Button**: Gradient (Violet to Teal), used for "New Post" or "Create Space", positioned bottom-right above nav
- **Bottom Navigation**: NOT frosted glass. Use solid Obsidian with a subtle top border. 4 items: Home (compass icon), Spaces (grid icon), Messages (chat icon), Profile (user icon). Active icon uses Nebula Violet fill.
- **Badges/Tags**: Pill-shaped, small, with role colors — Admin (Violet), Mod (Teal), Creator (Orange), Member (Graphite)

## 5. Layout Principles
- **Mobile-first**: 390px width
- **Home is Discovery**: The home screen is NOT a photo feed. It shows: Trending Spaces, Active Discussions, and Spaces you've joined — all as cards, NOT individual posts.
- **Inside a Space**: Resembles a modern channel-based layout — list of text channels on top, current channel content below, similar to Discord mobile but more visually rich.
- **Content Mix**: Posts inside channels can be text, polls, images, links, events — NOT just photos.
- **Threading**: Replies create visual threads with indentation and colored side-borders.
- **Navigation Depth**: Home → Space → Channel → Thread (clear breadcrumb hierarchy)

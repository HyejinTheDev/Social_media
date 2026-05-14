"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PostsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let PostsService = class PostsService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async getFeed(page, limit) {
        const skip = (page - 1) * limit;
        const [posts, total] = await Promise.all([
            this.prisma.post.findMany({
                skip,
                take: limit,
                orderBy: { createdAt: 'desc' },
                include: {
                    author: {
                        select: {
                            id: true,
                            name: true,
                            username: true,
                            avatar: true,
                        }
                    },
                    likes: true,
                    _count: {
                        select: {
                            likes: true,
                            comments: true,
                        }
                    }
                }
            }),
            this.prisma.post.count()
        ]);
        return {
            data: posts,
            meta: {
                total,
                page,
                limit,
                totalPages: Math.ceil(total / limit)
            }
        };
    }
    async getUserPosts(userId, page, limit) {
        const skip = (page - 1) * limit;
        const [posts, total] = await Promise.all([
            this.prisma.post.findMany({
                where: { authorId: userId },
                skip,
                take: limit,
                orderBy: { createdAt: 'desc' },
                include: {
                    author: {
                        select: { id: true, name: true, username: true, avatar: true }
                    },
                    likes: true,
                    _count: { select: { likes: true, comments: true } }
                }
            }),
            this.prisma.post.count({ where: { authorId: userId } })
        ]);
        return {
            data: posts,
            meta: {
                total,
                page,
                limit,
                totalPages: Math.ceil(total / limit)
            }
        };
    }
    async createPost(authorId, content, imageUrls, videoUrl) {
        return this.prisma.post.create({
            data: {
                content,
                authorId,
                imageUrls: imageUrls || [],
                videoUrl,
            },
            include: {
                author: {
                    select: {
                        id: true,
                        name: true,
                        username: true,
                        avatar: true,
                    }
                }
            }
        });
    }
    async getPostById(id) {
        const post = await this.prisma.post.findUnique({
            where: { id },
            include: {
                author: {
                    select: { id: true, name: true, username: true, avatar: true }
                },
                _count: {
                    select: { likes: true, comments: true }
                }
            }
        });
        if (!post)
            throw new common_1.NotFoundException('Post not found');
        return post;
    }
    async deletePost(id, authorId) {
        const post = await this.prisma.post.findUnique({ where: { id } });
        if (!post)
            throw new common_1.NotFoundException('Post not found');
        if (post.authorId !== authorId)
            throw new common_1.NotFoundException('Unauthorized to delete this post');
        return this.prisma.post.delete({ where: { id } });
    }
    async toggleLike(postId, userId) {
        const existingLike = await this.prisma.postLike.findUnique({
            where: {
                postId_userId: { postId, userId }
            }
        });
        if (existingLike) {
            await this.prisma.postLike.delete({ where: { id: existingLike.id } });
            await this.prisma.post.update({
                where: { id: postId },
                data: { likeCount: { decrement: 1 } }
            });
            return { liked: false };
        }
        else {
            await this.prisma.postLike.create({
                data: { postId, userId }
            });
            await this.prisma.post.update({
                where: { id: postId },
                data: { likeCount: { increment: 1 } }
            });
            return { liked: true };
        }
    }
    async getComments(postId) {
        return this.prisma.comment.findMany({
            where: { postId },
            orderBy: { createdAt: 'asc' },
            include: {
                author: {
                    select: { id: true, name: true, username: true, avatar: true }
                }
            }
        });
    }
    async createComment(postId, authorId, content, parentId) {
        const comment = await this.prisma.comment.create({
            data: {
                content,
                postId,
                authorId,
                parentId
            },
            include: {
                author: {
                    select: { id: true, name: true, username: true, avatar: true }
                }
            }
        });
        await this.prisma.post.update({
            where: { id: postId },
            data: { commentCount: { increment: 1 } }
        });
        return comment;
    }
};
exports.PostsService = PostsService;
exports.PostsService = PostsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], PostsService);
//# sourceMappingURL=posts.service.js.map
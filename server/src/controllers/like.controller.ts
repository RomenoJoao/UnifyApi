import { Request, Response } from "express";
import { Prisma, PrismaClient } from "@prisma/client";
import { ParserService } from "../utils/ParserService";

const prisma = new PrismaClient();
class LikeController {
  async getAll(req: Request, res: Response) {
    try {
      const { contentId } = req.body;
      const likes = await prisma.like.aggregate({
        where: {
          contentId: {
            equals: contentId,
          },
        },
        _count: true,
      });

      return res.status(200).json(likes);
    } catch (error: any) {
      console.log(error);
      return res.status(500).json({ message: error.message });
    }
  }

  async create(req: Request, res: Response) {
    try {
      const authorId = ParserService(
        req.headers.Authorization || req.cookies.tokens
      ).user_id;

      const { contentId } = req.body;

      const liked = await prisma.like.create({
        data: {
          author: {
            connect: {
              id: Number(authorId),
            },
          },
          content: {
            connect: {
              id: contentId,
            },
          },
        },
      });
      return res.status(200).json(liked);

    } catch (error: any) {
      console.log(error);
      return res.status(500).json({ message: error.message });
    }
  }
}

export default LikeController;

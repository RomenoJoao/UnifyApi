import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";
import { ParserService } from "../utils/ParserService";
import fs from "fs";
import { resolve } from "path";

const prisma = new PrismaClient();

class ContentClass {
  async create(req: Request, res: Response) {
    try {
      const { titulo, path, coverpath } = req.body;
      const user_id = ParserService(req.cookies.tokens).user_id;

      const content = await prisma.conteudo.create({
        data: {
          coverpath,
          path,
          titulo,
          author: {
            connect: {
              id: Number(user_id),
            },
          },
        },
      });

      return res.status(201).json(content);
    } catch (error: any) {
      console.log(error);
      return res.status(500).json({ message: error.message });
    }
  }

  async getAll(req: Request, res: Response) {
    try {
      const content = await prisma.conteudo.findMany();
      return res.status(200).json(content);
    } catch (error: any) {
      console.log(error);
      return res.status(500).json({ message: error.message });
    }
  }

  async getOne(req: Request, res: Response) {
    try {
      const { contentId } = req.params;
      const content = await prisma.conteudo.findUnique({
        where: {
          id: Number(contentId),
        },
        select: {
          id: true,
          titulo: true,
          path: true,
          coverpath: true,
          author: {
            select: {
              name: true,
              lastname: true,
            },
          },
          comentarios: {
            select: {
              id: true,
              texto: true,
              authorC: {
                select: {
                  name: true,
                  lastname: true,
                },
              },
              cratedAt: true,
            },
          },
          cratedAt: true,
        },
      });

      if (content) {
        const mappedContent = {
          id: content?.id,
          titulo: content?.titulo,
          path: content?.path,
          coverpath: content?.coverpath,
          author: content?.author.name + " " + content?.author.lastname,
          comentarios: content?.comentarios.map((comentario) => {
            return {
              id: comentario.id,
              texto: comentario.texto,
              authorC:
                comentario.authorC.name + " " + comentario.authorC.lastname,
              cratedAt: comentario.cratedAt,
            };
          }),
          cratedAt: content?.cratedAt,
        };
        return res.status(200).json(mappedContent);
      }

      return res.status(404).json({ message: "Conteudo não encontrado" });
    } catch (error: any) {
      console.log(error);
      return res.status(500).json({ message: error.message });
    }
  }
  async delete(req: Request, res: Response) {
    try {
      const { contentId } = req.params;

      const content = await prisma.conteudo.findUnique({
        where: {
          id: Number(contentId),
        },
      });

      const filename = content?.path || "";

      const coverpath = content?.coverpath || "";

      const path = resolve(__dirname, "..", "..", "uploads", filename);
      fs.unlink(path, async (err) => {
        if (err) {
          console.log(err);
          return res.status(400).json({ message: "Ficheiro não encontrado" });
        }
        fs.unlink(coverpath, async (err) => {
          if (err) {
            console.log(err);
            return res.status(400).json({ message: "Ficheiro não encontrado" });
          }
        });
        const file = await prisma.conteudo.delete({
          where: {
            id: Number(contentId),
          },
        });
        return res
          .status(200)
          .json({ file, message: "Ficheiro apagado com sucesso" });
      });
    } catch (error) {
      console.log(error);
      return res.status(400).json({ message: "Ficheiro não encontrado" });
    }
  }

  async update(req: Request, res: Response) {
    try {
      const { contentId } = req.params;
      const { titulo } = req.body;

      const content = await prisma.conteudo.update({
        where: {
          id: Number(contentId),
        },
        data: {
          titulo,
        },
      });

      return res.status(200).json(content);
    } catch (error) {
      console.log(error);
      return res.status(400).json({ message: "Conteudo não encontrado" });
    }
  }
}

export default ContentClass;

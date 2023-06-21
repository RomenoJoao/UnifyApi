import { Router } from "express";
import userRoutes from "./user.routes";
import authRoutes from "./auth.routes";
import fileRoutes from "./files.routes";
import contentRoutes from "./content.routes"
import likeRoutes from "./like.routes";
import commentRoutes from "./comment.routes";
import { ensureAuthenticated } from "../middleware/EnsureAuthenticated";



const router = Router();

router.use("/user", userRoutes);
router.use("/auth", authRoutes);
router.use("/file", fileRoutes);
router.use("/like",ensureAuthenticated, likeRoutes);
router.use("/comment",ensureAuthenticated, commentRoutes);
router.use("/conteudo",ensureAuthenticated,contentRoutes);

export default router;

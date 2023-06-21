import { Router } from "express";
import LikeController from "../controllers/like.controller";

const router = Router();
const likeController = new LikeController();

router.post("/", likeController.create);
router.get("/", likeController.getAll);
router.delete("/:likeid", likeController.delete);

export default router;

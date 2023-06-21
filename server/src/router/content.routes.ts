import { Router } from "express";
import ContentClass from "../controllers/content.controller";

const router = Router();
const contentClass = new ContentClass();

router.post("/", contentClass.create);
router.get("/", contentClass.getAll);
router.delete("/:contentId", contentClass.delete);

export default router;

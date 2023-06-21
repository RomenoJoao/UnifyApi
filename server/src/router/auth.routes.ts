import Router from "express";
import authController from "../controllers/auth.controller";

const router = Router();

router.post("/", authController.login);
router.get("/logout", authController.logout);
router.get("/me", authController.me);

export default router;

import z from "zod";

export const UserSchema = z.object({
  name: z
    .string()
    .min(3, { message: "O nome deve ter pelo menos 3 caracteres" }),
  lastname: z
    .string()
    .min(3, { message: "O nome deve ter pelo menos 3 caracteres" }),
  date: z.string().optional(),

  login: z.object({
    email: z
      .string()
      .email({ message: "Deve serEmail valido" })
      .refine((vaue) => vaue.includes("@isptec.co.ao"), {
        message: "Deve ser email institucional",
      }),
    password: z.string().min(6, { message: "Password invalida" }),
    role: z.string().optional(),
    username: z
      .string()
      .min(6, { message: "Deve conter mais de 6 caracteres" })
      .optional(),
  }),
});

export const updateSchema = z.object({
  name: z

    .string()
    .min(3, { message: "O nome deve ter pelo menos 3 caracteres" }),
  lastname: z
    .string()
    .min(3, { message: "O nome deve ter pelo menos 3 caracteres" }),
  date: z.string().optional(),

  login: z.object({
    email: z
      .string()
      .email({ message: "Deve serEmail valido" })
      .refine((vaue) => vaue.includes("@isptec.co.ao"), {
        message: "Deve ser email institucional",
      }),
    role: z.string().optional(),
    username: z
      .string()
      .min(6, { message: "Deve conter mais de 6 caracteres" })
      .optional(),
  }),
});

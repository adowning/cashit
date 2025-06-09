import { z } from 'zod';

// Common validation schemas
export const idSchema = z.string().uuid();
export const emailSchema = z.string().email();
export const usernameSchema = z.string().min(3).max(50);

// Validation helpers
export const validateWithSchema = <T>(
  schema: z.ZodSchema<T>,
  data: unknown
): { success: boolean; data?: T; error?: z.ZodError } => {
  const result = schema.safeParse(data);
  
  if (result.success) {
    return { success: true, data: result.data };
  }
  
  return { success: false, error: result.error };
};

// Common validation error formatter
export const formatValidationError = (error: z.ZodError): Record<string, string> => {
  const formattedErrors: Record<string, string> = {};
  
  error.errors.forEach((err) => {
    const path = err.path.join('.');
    formattedErrors[path] = err.message;
  });
  
  return formattedErrors;
};

// Common validation middleware
export const validateRequest = <T>(schema: z.ZodSchema<T>) => {
  return async (c: any, next: () => Promise<void>) => {
    const result = schema.safeParse(await c.req.json());
    
    if (!result.success) {
      return c.json(
        { 
          success: false, 
          error: 'Validation failed',
          details: formatValidationError(result.error) 
        },
        400
      );
    }
    
    c.req.validatedData = result.data;
    await next();
  };
};

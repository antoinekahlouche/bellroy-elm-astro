import { defineCollection, z } from "astro:content";
import { file } from "astro/loaders";

const products = defineCollection({
    // https://docs.astro.build/en/guides/content-collections/#building-a-custom-loader
    // Data can be loaded from anywhere: DB, Api...
    loader: file("src/assets/products.json"),
	schema: z.object({
		id: z.string(),
		name: z.string(),
		price: z.string(),
		colors: z.array(
			z.object({
				img: z.string(),
				name: z.string(),
				hex: z.string(),
			})
		),
		description: z.string(),
	}),
});

export const collections = { products };

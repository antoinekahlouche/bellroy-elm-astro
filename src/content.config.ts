import { defineCollection, z } from "astro:content";
import { file } from "astro/loaders";

const products = defineCollection({
	// https://docs.astro.build/en/guides/content-collections/#building-a-custom-loader
	// loader: file("src/assets/products.json"),
	loader: async () => {
		const response = await fetch(
			"https://raw.githubusercontent.com/antoinekahlouche/bellroy-elm-astro/refs/heads/main/src/assets/products.json"
		);
		const data = await response.json();
		return data.map((product: any) => ({
			id: product.id,
			...product,
		}));
	},
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

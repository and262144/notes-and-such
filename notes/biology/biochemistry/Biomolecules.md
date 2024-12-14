---
date: 2023-12-13
author: Satvik Anand
title: Basics of Biochemistry
---
:::{.handwritten}
Chemical Analysis
:::

```{.code-block}
def ChemicalAnalysis(type,tissue){

	if (type=='Basic Chemical Method'){
	
		slurry = tissue.grind(Mortar & Pestle)
		slurry.add(Tri Chloro acetic Acid)
		filterate,retentate = slurry.strain()
		filterate.add-property(Acid Soluble faction)
		retentate.add-property(Acid Insoluble faction)
		
	}
	
	else if (type=='Complex Analysis'){
			tissue.[[MassSpectrometry]]()
	}
	
	else if (type == "Inorganic Analysis"){
			wet-weight = tissue.weigh()
			tissue.dry() # tissue - water
			dry-weight = tissue.weigh()
			ash = tissue.burn() # tissue - carbon compounds
			ash.content() # Ca , Mg etc.
	}
	
	else{
			 tissue no shit !
	}

}
```


:::{.sticky-note}
There are many ways for analysis of tissues. This is the basic in NCERT books 
:::

:::{.handwritten}
Amino Acids
:::

```{.code-block}
def AminoAcids(Ligand,size,nature){

	extends Compounds()

	def1 = contain.AmineGroup() --> C1

	def2 = contain.CarboxylAcid() --> C1

	C1 = α carbon = attach point for everything

	C1.ValancePosition(){
		- Hydrogen() --> H
		- AmineGroup() --> NH₂
		- VariableGroup() --> R
		- CarboxylGroup() --> COOH
	}
	
	__self__.depends(R)
}
```

`` AminoAcids.display() ``

![Amino Acid basic Structure](./resources/amino-acid.jpg)

`` AmineGroup.display() ``

![Amine Group](./resources/amines.jpg)

`` CarboxylAcid.display() ``

![Carboxyl Group](./resources/carboxyl-group.png)

:::{.handwritten}
Types of Amino Acids
:::

```{.code-block}
def TypesOfAminoAcids(AminoAcids(),R){

	if(Body.produce=True){
		AminoAcid.type = Non-Essential Amino Acid
		if (R==''){
		
		}
	}
	
	else if(Body.produce=False){
		AminoAcid.type = Essential Amino Acid
	
	}
	
	else{
		AminoAcid.type = Semi-Essential Amino Acid
		
		if(R=='heterocyclic'){
			- Histidine(His)
				R group: CH₂-imidazole (aromatic ring with nitrogen)
		}
		
		if(R=='Basic'){
			- Arginine(Arg)
				R group: CH₂CH₂CH₂NHC(NH₂)₂ (guanidino group)
		}
	
	}
}

TypesOfAminoAcids.addContext('In Human Body')
```

### Essential Amino Acids  
| **Amino Acid**    | **3-Letter Code** | **R Group**                                   | **Diagram**                                                    |
|-------------------|-------------------|-----------------------------------------------|:-------------------------------------------------------------:|
| Isoleucine        | Ile               | $$CH(CH_3)(CH_2CH_3)$$                        | ![Isoleucine](https://aminoacidsguide.com/images/isoleucine.png) |
| Leucine           | Leu               | $$CH_2CH(CH_3)_2$$                            | ![Leucine](https://aminoacidsguide.com/images/leucine.png)      |
| Lysine            | Lys               | $$CH_2CH_2CH_2CH_2NH_2$$                      | ![Lysine](https://aminoacidsguide.com/images/lysine.png)        |
| Methionine        | Met               | $$CH_2CH_2SCH_3$$                             | ![Methionine](https://aminoacidsguide.com/images/methionine.png)|
| Phenylalanine     | Phe               | $$CH_2(C_6H_5)$$                              | ![Phenylalanine](https://aminoacidsguide.com/images/phenylalanine.png) |
| Threonine         | Thr               | $$CH(OH)CH_3$$                                | ![Threonine](https://aminoacidsguide.com/images/threonine.png)  |
| Tryptophan        | Trp               | $$CH_2-\text{indole ring}$$                   | ![Tryptophan](https://aminoacidsguide.com/images/tryptophan.png) |
| Valine            | Val               | $$CH(CH_3)_2$$                                | ![Valine](https://aminoacidsguide.com/images/valine.png)        |

### Non-Essential Amino Acids  
| **Amino Acid**    | **3-Letter Code** | **R Group**                                   | **Diagram**                                                    |
|-------------------|-------------------|-----------------------------------------------|:-------------------------------------------------------------:|
| Alanine           | Ala               | $$CH_3$$                                      | ![Alanine](https://aminoacidsguide.com/images/alanine.png)     |
| Asparagine        | Asn               | $$CH_2CONH_2$$                                | ![Asparagine](https://aminoacidsguide.com/images/asparagine.png) |
| Aspartic Acid     | Asp               | $$CH_2COOH$$                                  | ![Aspartic Acid](https://aminoacidsguide.com/images/aspartic-acid.png) |
| Glutamic Acid     | Glu               | $$CH_2CH_2COOH$$                              | ![Glutamic Acid](https://aminoacidsguide.com/images/glutamic-acid.png) |
| Serine            | Ser               | $$CH_2OH$$                                    | ![Serine](https://aminoacidsguide.com/images/serine.png)       |
| Proline           | Pro               | $$CH_2CH_2CH_2$$ (cyclic, bound to amine)     | ![Proline](https://aminoacidsguide.com/images/proline.png)     |
| Cysteine          | Cys               | $$CH_2SH$$                                    | ![Cysteine](https://aminoacidsguide.com/images/cysteine.png)   |
| Glutamine         | Gln               | $$CH_2CH_2CONH_2$$                            | ![Glutamine](https://aminoacidsguide.com/images/glutamine.png) |
| Tyrosine          | Tyr               | $$CH_2(C_6H_4OH)$$                            | ![Tyrosine](https://aminoacidsguide.com/images/tyrosine.png)   |

### Semi-Essential Amino Acids  
| **Amino Acid**    | **3-Letter Code** | **R Group**                                   | **Diagram**                                                    |
|-------------------|-------------------|-----------------------------------------------|:-------------------------------------------------------------:|
| Arginine          | Arg               | $$CH_2CH_2CH_2NHC(NH_2)_2$$ (guanidino group) | ![Arginine](https://aminoacidsguide.com/images/arginine.png)  |
| Histidine         | His               | $$CH_2-\text{imidazole ring}$$                | ![Histidine](https://aminoacidsguide.com/images/histidine.png)|




:::{.pencil-line}
:::

:::{.sources}

### Sources 
- Diagrams sourced from [Amino Acids Guide](https://aminoacidsguide.com).
- Information from NCERT Biology Grade 11 book 
- Truman Elementary Biology

:::

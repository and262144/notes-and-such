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
		filterate,retentate = slurry.strain()
		
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
		
	}
	
	else if(Body.produce=False){
	
		AminoAcid.type = Essential Amino Acid
	
	}
}

TypesOfAminoAcids.addContext('In Human Body')
```


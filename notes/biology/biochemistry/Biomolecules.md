---
date: 2023-12-13
author: Satvik Anand
title: Basics of Biochemistry
---
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

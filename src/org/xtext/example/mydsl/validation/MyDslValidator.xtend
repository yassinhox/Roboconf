package org.xtext.example.mydsl.validation

import org.xtext.example.mydsl.myDsl.Component
import org.xtext.example.mydsl.myDsl.Graph
import java.util.HashSet
import org.eclipse.xtext.validation.Check
import org.xtext.example.mydsl.myDsl.Facet
import java.util.ArrayList
import org.xtext.example.mydsl.myDsl.FacetsProperty
import org.xtext.example.mydsl.myDsl.ChildrenProperty
import org.xtext.example.mydsl.myDsl.ExportsVariable
import org.xtext.example.mydsl.myDsl.OptionalComponentProperty
import org.xtext.example.mydsl.myDsl.ImportsVariable
import org.xtext.example.mydsl.myDsl.FacetProperty
import org.xtext.example.mydsl.myDsl.Instance
import org.xtext.example.mydsl.myDsl.NameProperty
import org.xtext.example.mydsl.myDsl.OptionalInstanceProperty

/**
 * This class contains custom validation rules. 
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
class MyDslValidator extends AbstractMyDslValidator 
{		
	@Check(FAST) 
	def checkUndeclaredFacets(Graph g) 
	{	
		var facetNames = new ArrayList<String>;
	
		for (f : g.eAllContents.filter(Facet).toIterable)
		{
			facetNames.add(f.name);
		}
		for(c : g.eAllContents.filter(Component).toIterable)
		{
			var cp = c.properties;
			for (ittt : cp.optionalProperties) 
			{
				for (it : ittt.eAllContents.filter(FacetsProperty).toIterable) 
				{
					var subName = it.facetsNames.toString.substring(1,it.facetsNames.toString.length()-1);
					var subNames = new ArrayList<String>;
				  	var iterator = 0;
				  	var nbNames = 0;
				  	var name = "";
				  	var separator = ",";
				  	var space = " "; 
				  	while(iterator != subName.length)
				  	{
				  		if(subName.toString.charAt(iterator).equals(separator.toString.charAt(0)))
				  		{
				  			subNames.add(name);
				  			name="";
				  			nbNames++;
				  		}
				  		else if(subName.toString.charAt(iterator).equals(space.toString.charAt(0)))
				  		{
				  		}
				  		else
				  		{
				  			name=name+subName.toString.charAt(iterator).toString;
				  		}
				  		iterator++;
				  	}
				  	subNames.add(name);
				  	for(itt : subNames)
				  	{
				  		if(!facetNames.contains(itt))
				  		{
				  			error(it.facetsNames.toString+" not declared previoulsy",it,null);
				  		}
				  	}
				}
				
			}
		}
	}
	
	@Check(FAST)
	def checkUniqueComponent(Graph g)
	 {
		var compoNames = new ArrayList<String>; //Contiendra les noms des components déclarés
		for (c : g.eAllContents.filter(Component).toIterable)
		{
			if(compoNames.contains(c.name))
			{
				error(c.name+" declared more than once",c,null);
			}
			compoNames.add(c.name);
		}
	 }
	 
	 @Check(FAST)
	def checkUniqueFacet(Graph g)
	 {
		var facetNames = new ArrayList<String>; //Contiendra les noms des facets déclarés
		for (f : g.eAllContents.filter(Facet).toIterable)
		{
			if(facetNames.contains(f.name))
			{
				error(f.name+" declared more than once",f,null);
			}
			facetNames.add(f.name);
		}
	 }
	
	@Check(FAST)
	def checkUniqueChildren(Graph g)
	{
		for (f : g.eAllContents.filter(Facet).toIterable)
		{
			var facetChildrenNames = new ArrayList<String>; //Contiendra les noms des children de facets déclarés
			for(c : f.eAllContents.filter(ChildrenProperty).toIterable)
			{
				for(n : c.name)
				{
					if(facetChildrenNames.contains(n))
					{
						error(n+" used more than once",c,null);
					}
					facetChildrenNames.add(n);
				}
			}
		}
		for (c : g.eAllContents.filter(Component).toIterable)
		{
			var componentChildrenNames = new ArrayList<String>; //Contiendra les noms des children de components déclarés
			for(ch : c.eAllContents.filter(ChildrenProperty).toIterable)
			{
				for(n : ch.name)
				{
					if(componentChildrenNames.contains(n))
					{
						error(n+" used twice in same component",ch,null);
					}
					componentChildrenNames.add(n);
				}
			}
		}
	}
	
	@Check(FAST)
	def checkUniqueExport(Graph g)
	{
		for (f : g.eAllContents.filter(Facet).toIterable)
		{
			var facetExportNames = new ArrayList<String>; //Contiendra les noms des children de facets déclarés
			for(e : f.eAllContents.filter(ExportsVariable).toIterable)
			{
				if(facetExportNames.contains(e.name))
				{
					error(e.name+" used more than once",e,null);
				}
				facetExportNames.add(e.name);
			}
		}
		for (c : g.eAllContents.filter(Component).toIterable)
		{
			var componentExportNames = new ArrayList<String>; //Contiendra les noms des children de components déclarés
			for(e : c.eAllContents.filter(ExportsVariable).toIterable)
			{
				if(componentExportNames.contains(e.name))
				{
					error(e.name+" used more than once",e,null);
				}
				componentExportNames.add(e.name);
			}
		}
	}
	
	@Check(FAST)
	def checkUndeclaredChildren(Graph g)
	{	
		var Names = new ArrayList<String>; //Contiendra les noms des facets et compo déclarés

		for(c : g.eAllContents.filter(Component).toIterable)
		{
			if(!Names.contains(c.name))
			{
				Names.add(c.name);
			}
		}
		for (f : g.eAllContents.filter(Facet).toIterable)
		{
			for(c : f.eAllContents.filter(ChildrenProperty).toIterable)
			{
				for(n : c.name)
				{
					if(!Names.contains(n))
					{
						error(n+" undeclared",c,null);
					}
				}
			}
		}
		for (c : g.eAllContents.filter(Component).toIterable)
		{
			for(ch : c.eAllContents.filter(ChildrenProperty).toIterable)
			{
				for(n : ch.name)
				{
					if(!Names.contains(n))
					{
						error(n+" undeclared",ch,null);
					}
				}
			}
		}
	}
	
	def getComponentByName(Graph g, String componentName)
	{
		for (Component c : g.components)
		{
			if (c.name.equals(componentName)) return c;
		}
		return null;
	}
		
	def getFacetByName(Graph g, String facetName)
	{
		for (Facet f : g.facets)
		{
			if (f.name.equals(facetName)) return f;
		}
		return null;
	}
	
	def isComponentExportVariableExists(Component c, String exportVariableName)
	{
		for (OptionalComponentProperty ocp : c.properties.optionalProperties)
		{
			if (ocp.exportsProperty != null)
			{
				for (ExportsVariable v : ocp.exportsProperty.exportsVariables)
				{
					if (v.name.equals(exportVariableName))
					{
						return true;
					}
				}
			}
		}
		return false;
	}
	
	@Check(FAST)
	def checkValidImportsProperty(Graph g)
	{
		for (Component c : g.components)
		{
			for (OptionalComponentProperty ocp : c.properties.optionalProperties)
			{
				if (ocp.importsProperty != null)
				{
					for (ImportsVariable v : ocp.importsProperty.importsVariables)
					{
						if (!v.isIsExternal)
						{
							var cc = getComponentByName(g, v.componentName);
							if (cc == null)
							{
								error("component " + v.componentName + " does not exist", v, null);
							}
							if (!isComponentExportVariableExists(cc, v.componentProperty))
							{
								error("component " + cc.name + " does not export the variable " + v.componentProperty, v, null);
							}
						}
					}
				}
			}
		}
	}
	
	@Check(FAST)
	def checkUndeclaredComponentExtends(Graph g)
	{
		for (Component c : g.components)
		{
			for (OptionalComponentProperty ocp : c.properties.optionalProperties)
			{
				if (ocp.extendsProperty != null)
				{
					for (String en : ocp.extendsProperty.extendsNames)
					{
						val componentName = getComponentByName(g, en);
						if (componentName == null)
						{
							error("component " + en + " does not exist", ocp.extendsProperty, null);
						}
					}
				}
			}
		}
	}
	
	@Check(FAST)
	def checkUndeclaredFacetExtends(Graph g)
	{
		for (Facet f : g.facets)
		{
			for (FacetProperty fp : f.properties.properties)
			{
				if (fp.extendsProperty != null)
				{
					for (String en : fp.extendsProperty.extendsNames)
					{
						val facetName = getFacetByName(g, en);
						if (facetName == null)
						{
							error("facet " + en + " does not exist", fp.extendsProperty, null);
						}
					}
				}
			}
		}
	}
	
	@Check(FAST)
	def checkInstanceOfUniqueVariable(Instance i)
	{
		val names = new HashSet<String>();
		for (OptionalInstanceProperty ip : i.properties.optionalProperties)
		{
			if (ip.exportedVariablesProperty != null)
			{
				if (names.contains(ip.exportedVariablesProperty.name))
				{
					error("property defined more than once", ip.exportedVariablesProperty, null);
				}
				names.add(ip.exportedVariablesProperty.name);
			}
		}	
	}
	
	@Check(FAST)
	def checkUniqueInstances(Graph g)
	{
		var instanceNames = new ArrayList<String>; //Contiendra les noms des facets déclarés
		for (i : g.eAllContents.filter(NameProperty).toIterable)
		{
			if(instanceNames.contains(i.name))
			{
				error(i.name+" declared more than once",i,null);
			}
			instanceNames.add(i.name);
		}
	}

	@Check(FAST)
	def checkUndeclaredInstance(Graph g)
	{
		var componentNames = new ArrayList<String>();
	
		for(c : g.eAllContents.filter(Component).toIterable)
		{
			if(!componentNames.contains(c.name))
			{
				componentNames.add(c.name);
			}
		}
		for (i : g.eAllContents.filter(Instance).toIterable)
		{
			if(!componentNames.contains(i.name))
			{
				error(i.name+" undeclared",i,null);
			}
		}
	}

}


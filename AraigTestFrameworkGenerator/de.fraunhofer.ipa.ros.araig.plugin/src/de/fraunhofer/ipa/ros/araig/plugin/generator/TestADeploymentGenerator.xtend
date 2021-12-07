package de.fraunhofer.ipa.ros.araig.plugin.generator;

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.eclipse.xtext.generator.IOutputConfigurationProvider
import org.eclipse.xtext.generator.OutputConfiguration
import java.util.Set

import ros.Publisher

class CustomOutputProvider implements IOutputConfigurationProvider {
	public final static String ARAIG_OUTPUT = "ARAIG_OUTPUT"
	
	override Set<OutputConfiguration> getOutputConfigurations() {
		var OutputConfiguration observer_config = new OutputConfiguration(ARAIG_OUTPUT)
		observer_config.setDescription("ARAIG_OUTPUTs");
		observer_config.setOutputDirectory("./src-gen/araig/");
		observer_config.setOverrideExistingResources(true);
		observer_config.setCreateOutputDirectory(true);
		observer_config.setCleanUpDerivedResources(true);
		observer_config.setSetDerivedProperty(true);
		return newHashSet(observer_config)
	}
}


class TestADeploymentGenerator extends AbstractGenerator {
	
	def void createXtextGenerationFolder (IFileSystemAccess2 fsa, IGeneratorContext context) {
		fsa.generateFile("lock",CustomOutputProvider::ARAIG_OUTPUT,'''''');
		fsa.deleteFile("lock",CustomOutputProvider::ARAIG_OUTPUT);
	}

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
			for (publisher : resource.allContents.toIterable.filter(Publisher)){
				fsa.generateFile("araig.launch",CustomOutputProvider::ARAIG_OUTPUT,publisher.compile)
				}
			}

def compile(Publisher publisher) {
'''
«publisher.name» «publisher.message»
'''
}

}
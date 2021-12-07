package de.fraunhofer.ipa.ros.araig.plugin.generator;

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.eclipse.xtext.generator.IOutputConfigurationProvider
import org.eclipse.xtext.generator.OutputConfiguration
import java.util.Set

import ros.Publisher

class TestBDeploymentGenerator extends AbstractGenerator {
	
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
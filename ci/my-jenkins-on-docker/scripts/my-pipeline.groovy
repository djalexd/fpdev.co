import jenkins.model.Jenkins
import groovy.transform.TupleConstructor
import groovy.text.SimpleTemplateEngine

def engine = new SimpleTemplateEngine()

/* Represents a seed job project. */
@TupleConstructor
class SeedProject {
	String name
	String gitRepoUrl
	String branch = '*/master'
	String jenkinsFile = 'Jenkinsfile'
	String description = ''
}

/* This can even be stored outside (e.g. local file, remote file, http server)! */
def seeds = [
	new SeedProject(name = 'djalexd - TodoApp', gitRepoUrl = 'https://github.com/djalexd/ToDoApp.git'),
	new SeedProject(name = 'alexpeptan - TodoApp', gitRepoUrl = 'https://github.com/alexpeptan/ToDoApp.git')
]

seeds.each {
	def contents = new File('/usr/share/jenkins/ref/seed-templates', 'pipelineJob.xml').text.toString()
	if (!Jenkins.instance.getItemMap().containsKey(it.name)) {
		/* Create the binding for our template */
		def binding = [
			gitRepoUrl: it.gitRepoUrl,
			branch: it.branch,
			jenkinsFile: it.jenkinsFile,
			description: it.description
		]
		def template = engine.createTemplate(contents).make(binding)
		def stream = new java.io.StringBufferInputStream(template.toString())
		/* Finally, create the pipeline jobs with this data. */
		Jenkins.instance.createProjectFromXML(it.name, stream)
	} else {
		println("There already is a job named ${it.name}")
	}
}
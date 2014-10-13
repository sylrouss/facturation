require 'rubygems'
require 'rake/classic_namespace'
require 'rake/clean'
require 'yaml'
require 'erb'

CLEAN.include(['*.tex', '*.synctex.gz', '*.pdf', '*.log', '*.aux'])
CLOBBER.include(['*.tex', '*.synctex.gz', '*.pdf', '*.log', '*.aux'])

CONFIG = YAML.load_file('config.yaml')

rule '.tex', :client do |t, args|
  CLIENT = args[:client]
  template = ERB.new(File.new("#{t.name}.tpl").read, nil, "%")
  File.open(t.name, 'w+') {|f| f.write(template.result) }
end

rule '.pdf', :client => '.tex' do | t|
  sh "pdflatex #{t.source}"
end

desc("Generate 'invoice' for a client")
task :invoice, [:client] => ['facture.pdf']

desc("Generate 'devis' for a client")
task :devis, [:client] => ['devis.pdf']

desc("Generate 'avoir' for a client")
task :avoir, [:client] => ['avoir.pdf']

desc("Generate 'expense' report for a client")
task :expense, [:client] => ['note_frais.pdf']
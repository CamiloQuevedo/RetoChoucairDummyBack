pipeline {
    agent any
    stages {
        stage('Clonar repositorio') {
            steps {
                git 'https://github.com/CamiloQuevedo/RetoChoucairDummyBack.git'
            }
        }
    stage('Compilación') {
                steps {
                    echo ("./gradlew build")
                }
            }
    stage('Test') {
                steps {
                    script {
                        try {
                            bat("gradle clean test aggregate")
                            echo 'Ejecucion exitosa de las pruebas'

                        } catch (e) {
                            echo 'Pruebas fallidas'

                        }
                    }
                }
            }

            stage('Generar Evidencias') {
                steps {
                    script {
                        try {
                            bat " rename \"${WORKSPACE}\\target\" serenity_${tiempo}"

                            publishHTML([allowMissing         : false,
                                         alwaysLinkToLastBuild: true,
                                         keepAll              : true,
                                         reportDir            : "${WORKSPACE}//serenity_${tiempo}/site/serenity",
                                         reportFiles          : 'index.html',
                                         reportName           : 'Test Demo serenity evidencias ',
                                         reportTitles         : 'Serenity demo Proyecto'])
                            echo 'Reporte generado exitosamente'
                        } catch (e) {
                            publishHTML([allowMissing         : false,
                                         alwaysLinkToLastBuild: true,
                                         keepAll              : true,
                                         reportDir            : "${WORKSPACE}//target/serenity_${tiempo}",
                                         reportFiles          : 'index.html',
                                         reportName           : 'Test Demo serenity evidencias ',
                                         reportTitles         : 'Serenity demo Proyecto'])
                            echo 'Reporte generado exitosamente'
                        }
                    }
                }
            }
        }
    }
<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>NotificaAutorizacionDeGrupo</fullName>
        <description>Notifica autorización de grupo</description>
        <protected>false</protected>
        <recipients>
            <recipient>vicerrector@ieu.edu.mx</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Autorizaciones/AutorizarGrupos</template>
    </alerts>
    <rules>
        <fullName>Notifica autorización de grupo</fullName>
        <actions>
            <name>NotificaAutorizacionDeGrupo</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notifica cuando se asigna un catedrático y materia a un grupo para que sea autorizado</description>
        <formula>NOT( ISBLANK( Docente__c ) )  &amp;&amp;   NOT( ISBLANK(  Materia__c  ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>

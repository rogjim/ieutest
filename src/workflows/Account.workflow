<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CopiaEstado</fullName>
        <field>EstadoOtro__c</field>
        <formula>Estado__r.Name</formula>
        <name>Copia estado</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Copia estado Cuenta</fullName>
        <actions>
            <name>CopiaEstado</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>IF(Pais__r.Name = &quot;MEXICO&quot;, True, False)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>NombreBCA</fullName>
        <field>Name</field>
        <formula>BecaConvenio__r.NombreConvenio__c &amp; &apos; - &apos; &amp;   Plantel__r.Name &amp; &apos; - &apos; &amp;    Nivel__r.Name</formula>
        <name>Nombre BCA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Nombre BCA</fullName>
        <actions>
            <name>NombreBCA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>BecaConvenioAsignacion__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

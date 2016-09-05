<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ImportePorDescuento</fullName>
        <field>TotaPagar__c</field>
        <formula>Importe__c -(Importe__c * Descuento__c )</formula>
        <name>ImportePorDescuento</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Ficha móvil</fullName>
        <actions>
            <name>ImportePorDescuento</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>FichaPago__c.TipoFicha__c</field>
            <operation>equals</operation>
            <value>Ficha Móvil</value>
        </criteriaItems>
        <description>Calcula el descuento para una ficha móvil</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>

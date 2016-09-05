<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ActualizaTRGanada</fullName>
        <description>Cuando se actualiza el estado ganada</description>
        <field>RecordTypeId</field>
        <lookupValue>OpportunityGanada</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>ActualizaTRGanada</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Llenar_Importe</fullName>
        <field>Amount</field>
        <formula>ImporteTotal__c</formula>
        <name>Llenar Importe</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Tipo_de_negocio</fullName>
        <field>Type</field>
        <literalValue>Nuevo Negocio</literalValue>
        <name>Tipo de negocio</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Tipo_de_negocio2</fullName>
        <field>Type</field>
        <literalValue>Negocio Existente</literalValue>
        <name>Tipo de negocio2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Copia Importe</fullName>
        <actions>
            <name>Llenar_Importe</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.ImporteTotal__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OpportunityGanada</fullName>
        <actions>
            <name>ActualizaTRGanada</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Inscrito,Ganada</value>
        </criteriaItems>
        <description>Bloqueo las modificaciones de la oportunidad con estado Ganda Inscritas</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Tipo de negocio</fullName>
        <actions>
            <name>Tipo_de_negocio</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>IF(  ISBLANK(TEXT(Type)),  
     IF( EsConvertido__c , True, False) , 
     False)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Tipo de negocio 2</fullName>
        <actions>
            <name>Tipo_de_negocio2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>IF(  ISBLANK(TEXT(Type)),  
     IF( EsConvertido__c ,False,True) , 
     False)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

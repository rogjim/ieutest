<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>BecaAutorizada</fullName>
        <description>Beca Autorizada</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Autorizaciones/BecaAutorizada</template>
    </alerts>
    <alerts>
        <fullName>RechazaBeca</fullName>
        <description>Rechaza Beca</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Autorizaciones/BecaRechazada</template>
    </alerts>
    <fieldUpdates>
        <fullName>AutorizaBecas</fullName>
        <field>Estatus__c</field>
        <literalValue>Activo</literalValue>
        <name>Autoriza becas</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RechazaBeca</fullName>
        <field>Estatus__c</field>
        <literalValue>Rechazada</literalValue>
        <name>Rechaza Beca</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>

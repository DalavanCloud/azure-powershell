﻿// ----------------------------------------------------------------------------------
//
// Copyright Microsoft Corporation
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ----------------------------------------------------------------------------------


using System;
using System.Globalization;
using System.Linq;
using System.Management.Automation;
using Microsoft.AzureStack.AzureConsistentStorage.Models;

namespace Microsoft.AzureStack.AzureConsistentStorage.Commands.Fault
{
    /// <summary>
    ///     get fault history
    ///    
    ///     SYNTAX
    ///         Get-FaultHistory [-SubscriptionId] {string} [-Token] {string} [-AdminUri] {Uri} [-ResourceGroupName] {string} 
    ///             [-SkipCertificateValidation] [-FarmName] {string} -StartTime {DateTime} -EndTime {DateTime} [-ResourceUri {string}]
    ///             [{CommonParameters}]  
    /// 
    /// </summary>
    [Cmdlet(VerbsCommon.Get, Nouns.AdminFaultHistory)]
    public sealed class GetFaultHistory : AdminCmdlet
    {
        /// <summary>
        /// Resource group name
        /// </summary>
        [Parameter(Position = 3, Mandatory = true, ValueFromPipelineByPropertyName = true)]
        [ValidateNotNull]
        public string ResourceGroupName { get; set; }

        /// <summary>
        ///     Farm Identifier
        /// </summary>
        [Parameter(Mandatory = true, ValueFromPipelineByPropertyName = true, Position = 4)]
        [ValidateNotNull]
        public string FarmName
        {
            get;
            set;
        }

        /// <summary>
        ///     Query Fault StartTime 
        /// </summary>
        [Parameter(Mandatory = true)]
        [ValidateNotNull]
        public DateTime StartTime
        {
            get;
            set;
        }

        /// <summary>
        ///     Query Fault EndTime 
        /// </summary>
        [Parameter(Mandatory = true)]
        [ValidateNotNull]
        public DateTime EndTime
        {
            get;
            set;
        }

        /// <summary>
        ///     Resource Uri
        /// </summary>
        [Alias("Id")]
        [Parameter(Mandatory = false, ValueFromPipelineByPropertyName = true)]
        [ValidateNotNull]
        public string ResourceUri
        {
            get;
            set;
        }

        protected override void Execute()
        {
            FaultListResponse faults = Client.Faults.ListHistoryFaults(ResourceGroupName, FarmName,
                           StartTime.ToString("O", CultureInfo.InvariantCulture),
                           EndTime.ToString("O", CultureInfo.InvariantCulture),
                           ResourceUri);
            WriteObject(faults.Select(_ => new FaultResponse(_)), true);
        }
    }
}

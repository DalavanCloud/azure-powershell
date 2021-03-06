// ----------------------------------------------------------------------------------
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

using System.Management.Automation;
using Microsoft.AzureStack.AzureConsistentStorage;
using Microsoft.AzureStack.AzureConsistentStorage.Models;

namespace Microsoft.AzureStack.AzureConsistentStorage.Commands
{
    /// <summary>
    ///     SYNTAX
    ///          Get-ManagementServiceMetric [-SubscriptionId] {string} [-Token] {string} [-AdminUri] {Uri} [-ResourceGroupName] {string} 
    ///             [-SkipCertificateValidation] [-FarmName] {string}
    ///             [[-StartTime] {DateTime}] [[-EndTime] {DateTime}] [[-TimeGrain] {TimeGrain}] [[-MetricNames] {string[]}] [ {CommonParameters}]
    /// 
    /// </summary>
    [Cmdlet(VerbsCommon.Get, Nouns.AdminManagementServiceMetric)]
    public sealed class GetManagementServiceMetrics : AdminMetricCmdlet
    {
        /// <summary>
        ///     Farm Identifier
        /// </summary>
        [Parameter(Mandatory = true, ValueFromPipelineByPropertyName = true, Position = 4)]
        [ValidateNotNull]
        public string FarmName { get; set; }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="filter"></param>
        /// <returns></returns>
        protected override MetricsResult GetMetricsResult(string filter)
        {
            return Client.ManagementService.GetMetrics(ResourceGroupName, FarmName, filter);
        }
    }
}
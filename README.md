# SOC Analyst Practical Labs

A hands-on cybersecurity portfolio covering SIEM log ingestion, Windows endpoint monitoring, Linux system logging, operating-system auditing and security-event investigation with Splunk.

The repository contains two practical labs aligned with skills used in entry-level Security Operations Centre (SOC) roles and topics covered by CompTIA CySA+.

## Labs

| Lab | Focus | Main skills |
| --- | --- | --- |
| [Lab 1 – SIEM Log Ingestion](Lab-01-Log-Ingestion/README.md) | Centralise Windows and Linux telemetry in Splunk Enterprise | Splunk Universal Forwarder, Sysmon, Windows Event Logs, rsyslog, UDP/TCP forwarding and SPL |
| [Lab 2 – Operating System Concepts](Lab-02-OS-Concepts/README.md) | Generate and investigate operating-system security events | Windows Audit Policy, registry monitoring, process creation, Sysmon, Linux auditd and SPL |

## Lab environment

The practical work uses virtual machines in Oracle VirtualBox:

- **SIEM:** Splunk Enterprise running in the lab environment.
- **Windows endpoint:** Windows 11 with Splunk Universal Forwarder and Sysmon.
- **Linux endpoint:** Ubuntu with rsyslog and auditd.
- **Windows forwarding:** TCP port `9997` from the Universal Forwarder to Splunk.
- **Linux syslog forwarding:** UDP port `1514` from rsyslog to Splunk.

The indexes used in the exercises are:

| Index | Intended data |
| --- | --- |
| `sysmon` | Sysmon Operational events from Windows |
| `wineventlog` | Windows Application, Security, System and Firewall events |
| `main` | Linux syslog and, where configured, Linux audit records |

Actual index names, source types and extracted field names depend on the Splunk inputs and add-ons configured in the running environment. Confirm them with searches before relying on a field in an investigation.

## Repository structure

```text
splunk-soc-log-ingestion-lab/
├── README.md
├── Lab-01-Log-Ingestion/
│   ├── README.md
│   ├── Configs/
│   │   ├── inputs.conf
│   │   └── outputs.conf
│   ├── Queries/
│   │   └── investigation-queries.spl
│   ├── Scripts/
│   │   └── UF.ps1
│   └── Screenshots/
└── Lab-02-OS-Concepts/
    ├── README.md
    ├── Configs/
    │   └── sshd.rules
    ├── Queries/
    │   └── os-concepts-queries.spl
    ├── Scripts/
    │   ├── 01_generate_events.ps1
    │   ├── 02_linux_audit_setup.sh
    │   └── OSConcepts.ps1
    └── Screenshots/
```

## How to use this repository

1. Start with the relevant lab README.
2. Review the configuration files before applying them.
3. Read each script before running it. Some Windows steps require an elevated PowerShell session; Linux setup commands use `sudo`.
4. Run the exercises only in isolated test virtual machines that you control.
5. Use the supplied SPL searches in Splunk Search to investigate the generated events.
6. Compare your results with the screenshots, and capture your own results if you repeat the lab in a different environment.

## Evidence and verification

The `Screenshots` folders contain evidence captured during the exercises. They document selected configuration screens, generated activity and Splunk search results. A screenshot is evidence of the displayed result at the time it was captured; it does not guarantee that a different environment is configured identically.

**Current evidence summary:**

- Lab 1 includes screenshots of the Splunk UDP 1514 input, Linux test-message ingestion and Windows/Sysmon event searches.
- Lab 2 includes screenshots of Windows audit-policy configuration, process-creation events, registry monitoring and Linux auditd activity.
- Local auditd event generation and delivery of those audit records into Splunk are separate verification steps. The current Lab 2 screenshots do not conclusively prove that the actual `/etc/ssh/sshd_config` audit records are indexed in Splunk; see the Lab 2 README.

## Safety and configuration notes

- These are educational lab examples, not production-ready deployment scripts.
- Review scripts and configuration files before execution.
- The Lab 1 forwarder configuration contains a lab-network destination address and a Windows host value. Replace these with the correct values for your own environment before reuse.
- The Lab 2 Linux exercise changes SSH authentication configuration. Use a VM console or ensure you have an alternative way to access the machine before restarting SSH. Keep a backup and restore it after testing.
- Do not commit passwords, access tokens, private keys or other secrets to this repository.

## Skills demonstrated

- SIEM log collection and indexing
- Windows Event Log and Sysmon monitoring
- Splunk Universal Forwarder configuration
- Linux syslog forwarding with rsyslog
- Windows security auditing and registry monitoring
- Linux file-integrity auditing with auditd
- SPL searching, filtering and event triage
- Basic troubleshooting and evidence documentation

---

**Portfolio:** SOC Analyst Practical Labs  
**Tools:** Splunk Enterprise, Sysmon, Splunk Universal Forwarder, rsyslog, auditd, PowerShell, Ubuntu and Windows 11  
**Virtualisation:** Oracle VirtualBox

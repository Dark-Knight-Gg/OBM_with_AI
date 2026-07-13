class ListContractStatus {
  final String code;
  final String label;
  final String badge;

  const ListContractStatus({required this.code, required this.label, required this.badge});
}

class ConfigFilterApp {
  static const List<ListContractStatus> projectStatuses = [
    ListContractStatus(code: 'PLANNING', label: 'Lập kế hoạch', badge: 'bg-secondary'),
    ListContractStatus(code: 'IN_PROGRESS', label: 'Đang thực hiện', badge: 'bg-primary'),
    ListContractStatus(code: 'ON_HOLD', label: 'Tạm dừng', badge: 'bg-warning'),
    ListContractStatus(code: 'COMPLETED', label: 'Hoàn thành', badge: 'bg-success'),
    ListContractStatus(code: 'CANCELLED', label: 'Đã hủy', badge: 'bg-secondary'),
  ];
  static const List<ListContractStatus> projectFields = [
    ListContractStatus(code: 'EGOV', label: 'Chính phủ điện tử', badge: 'bg-secondary'),
    ListContractStatus(code: 'HEALTH', label: 'Y tế', badge: 'bg-primary'),
    ListContractStatus(code: 'EDUCATION', label: 'Giáo dục', badge: 'bg-warning'),
    ListContractStatus(code: 'FINANCE', label: 'Tài chính - Ngân hàng', badge: 'bg-success'),
    ListContractStatus(code: 'TELECOM', label: 'Viễn thông', badge: 'bg-secondary'),
    ListContractStatus(code: 'ENTERPRISE', label: 'Doanh nghiệp', badge: 'bg-primary'),
    ListContractStatus(code: 'TRANSPORT', label: 'Giao thông', badge: 'bg-warning'),
    ListContractStatus(code: 'AGRICULTURE', label: 'Nông nghiệp', badge: 'bg-success'),
    ListContractStatus(code: 'OTHER', label: 'Khác', badge: 'bg-secondary'),
  ];

  static const List<ListContractStatus> contractStatuses = [
    ListContractStatus(code: 'DRAFT', label: 'Dự thảo', badge: '#6C757D'),
    ListContractStatus(code: 'SIGNED', label: 'Đã ký', badge: '#0A6FFD'),
    ListContractStatus(code: 'ACTIVE', label: 'Đang hiệu lực', badge: '#198755'),
    ListContractStatus(code: 'EXPIRING', label: 'Sắp hết hạn', badge: '#FFC106'),
    ListContractStatus(code: 'EXPIRED', label: 'Hết hạn', badge: '#212529'),
    ListContractStatus(code: 'LIQUIDATED', label: 'Đã thanh lý', badge: '#10CAF0'),
  ];
}

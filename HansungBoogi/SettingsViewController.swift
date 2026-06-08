import UIKit

class SettingsViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "설정"
        view.backgroundColor = .systemGroupedBackground

        setupLayout()
        addAppInfoSection()
        addDataManagementSection()
    }

    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = 20
        contentStackView.alignment = .fill

        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 24),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -24)
        ])
    }

    private func addAppInfoSection() {
        let sectionStackView = makeSectionStackView()
        sectionStackView.addArrangedSubview(makeSectionTitleLabel("앱 정보"))
        sectionStackView.addArrangedSubview(makeInfoRow(title: "앱 이름", value: "한성부기 캠퍼스 내비게이터"))
        sectionStackView.addArrangedSubview(makeInfoRow(title: "만든 사람", value: "2371046 김병철"))
        sectionStackView.addArrangedSubview(makeInfoRow(title: "버전", value: "1.8"))

        contentStackView.addArrangedSubview(sectionStackView)
    }

    private func addDataManagementSection() {
        let sectionStackView = makeSectionStackView()
        sectionStackView.addArrangedSubview(makeSectionTitleLabel("데이터 관리"))
        sectionStackView.addArrangedSubview(makeActionButton(title: "최근 검색기록 삭제", action: #selector(confirmClearRecentSearches)))
        sectionStackView.addArrangedSubview(makeSeparatorView())
        sectionStackView.addArrangedSubview(makeActionButton(title: "즐겨찾기 전체 삭제", action: #selector(confirmClearFavorites)))

        contentStackView.addArrangedSubview(sectionStackView)
    }

    private func makeSectionStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.backgroundColor = .secondarySystemGroupedBackground
        stackView.layer.cornerRadius = 12
        stackView.clipsToBounds = true
        return stackView
    }

    private func makeSectionTitleLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .secondaryLabel
        label.backgroundColor = .systemGroupedBackground
        label.numberOfLines = 0
        label.layoutMargins = UIEdgeInsets(top: 0, left: 4, bottom: 8, right: 4)

        let container = UILabel()
        container.text = text
        container.font = label.font
        container.textColor = label.textColor
        container.backgroundColor = label.backgroundColor
        container.numberOfLines = label.numberOfLines
        container.translatesAutoresizingMaskIntoConstraints = false
        container.heightAnchor.constraint(greaterThanOrEqualToConstant: 32).isActive = true
        return container
    }

    private func makeInfoRow(title: String, value: String) -> UIView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.spacing = 12
        rowStackView.alignment = .center
        rowStackView.layoutMargins = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
        rowStackView.isLayoutMarginsRelativeArrangement = true

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = .label

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 16, weight: .regular)
        valueLabel.textColor = .secondaryLabel
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = 0

        rowStackView.addArrangedSubview(titleLabel)
        rowStackView.addArrangedSubview(valueLabel)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return rowStackView
    }

    private func makeActionButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.contentHorizontalAlignment = .leading
        button.contentEdgeInsets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    private func makeSeparatorView() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .separator
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return separator
    }

    @objc private func confirmClearRecentSearches() {
        showConfirmationAlert(
            title: "최근 검색기록 삭제",
            message: "최근 검색기록을 모두 삭제할까요?",
            confirmTitle: "삭제"
        ) {
            RecentSearchManager.shared.removeAllRecentSearches()
        }
    }

    @objc private func confirmClearFavorites() {
        showConfirmationAlert(
            title: "즐겨찾기 전체 삭제",
            message: "즐겨찾기를 모두 삭제할까요?",
            confirmTitle: "삭제"
        ) {
            FavoritesManager.shared.removeAllFavorites()
        }
    }

    private func showConfirmationAlert(
        title: String,
        message: String,
        confirmTitle: String,
        confirmAction: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: confirmTitle, style: .destructive) { _ in
            confirmAction()
            self.showCompletionAlert(message: "삭제되었습니다.")
        })
        present(alert, animated: true)
    }

    private func showCompletionAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

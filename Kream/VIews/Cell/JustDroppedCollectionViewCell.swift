import UIKit
import SnapKit
import Kingfisher

class JustDroppedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "JustDroppedCell" // 셀 식별자 추가
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let bookmarkButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "bookmark")
        configuration.baseForegroundColor = .black

        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)

        // 클릭 시 하이라이트 효과 제거
        button.configurationUpdateHandler = { button in
            var config = button.configuration
            if button.isHighlighted {
                config?.baseBackgroundColor = .clear // 하이라이트 시에도 배경색 변경 없이 유지
                button.alpha = 1.0 // 알파값 조정으로 시각적인 효과 제거
            }
            button.configuration = config
        }

        return button
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.numberOfLines = 2 // 최대 2줄로 설정
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let purchaseInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(bookmarkButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(purchaseInfoLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(142)
        }

        bookmarkButton.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom).offset(-8)
            make.trailing.equalTo(imageView.snp.trailing).offset(-8)
            make.width.height.equalTo(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        purchaseInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    @objc func bookmarkButtonTapped() {
        bookmarkButton.isSelected.toggle()
        let imageName = bookmarkButton.isSelected ? "bookmark.fill" : "bookmark"
        let icon = UIImage(systemName: imageName)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        bookmarkButton.setImage(icon, for: .normal)
    }
    // MARK: - KingFisher 사용 부분
    func configure(with item: JustDroppedItem) {
        // Kingfisher를 사용해 URL로 이미지를 로드하도록 .
        // 1. item.imageUrl을 URL 객체로 변환
        if let url = URL(string: item.imageUrl) {
            // 2. Kingfisher의 setImage 메서드를 사용해서 네트워크에서 이미지를 가져오도록
            
            imageView.kf.setImage(with: url)
        } else {
            // 3. URL 변환이 실패했을 경우를 생각해서 nil로 설정하기
            imageView.image = nil
        }
        
        //제목, 설명, 가격 , 즉시구매 택스트 값이 뜨도록 ..
        
        // 제목
        titleLabel.text = item.title
        
        // 설명
        descriptionLabel.text = item.description
        
        // 가격
        priceLabel.text = item.price
   
        //즉시구매가
        purchaseInfoLabel.text = item.purchaseInfo
    }

}


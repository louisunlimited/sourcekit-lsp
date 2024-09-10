//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import LanguageServerProtocol

/// The SourceKitOptions request is sent from the client to the server to query for the list of compiler options
/// necessary to compile this file in the given target.
///
/// The build settings are considered up-to-date and can be cached by SourceKit-LSP until a
/// `DidChangeBuildTargetNotification` is sent for the requested target.
///
/// The request may return `nil` if it doesn't have any build settings for this file in the given target.
public struct SourceKitOptionsRequest: RequestType, Hashable {
  public static let method: String = "textDocument/sourceKitOptions"
  public typealias Response = SourceKitOptionsResponse?

  /// The URI of the document to get options for
  public var textDocument: TextDocumentIdentifier

  /// The target for which the build setting should be returned.
  ///
  /// A source file might be part of multiple targets and might have different compiler arguments in those two targets,
  /// thus the target is necessary in this request.
  public var target: BuildTargetIdentifier

  public init(textDocument: TextDocumentIdentifier, target: BuildTargetIdentifier) {
    self.textDocument = textDocument
    self.target = target
  }
}

public struct SourceKitOptionsResponse: ResponseType, Hashable {
  /// The compiler options required for the requested file.
  public var compilerArguments: [String]

  /// The working directory for the compile command.
  public var workingDirectory: String?

  public init(compilerArguments: [String], workingDirectory: String? = nil) {
    self.compilerArguments = compilerArguments
    self.workingDirectory = workingDirectory
  }
}